require_relative '../lib/open_badges'
require 'timecop'
require 'digest'

describe OpenBadges::Assertion do
  # Timecop freezes time
  before(:all) { Timecop.freeze(Time.local(2012, 8, 26, 12, 0, 0)) }
  after(:all) { Timecop.return }

  def digest message
    Digest::SHA256.hexdigest(message)
  end

  let(:assertion) { described_class.new }

  context "#as_json" do
    subject { assertion.as_json }

    before do
      OpenBadges.issuer_url = "http://www.codeschool.com"
      OpenBadges.issuer_name = "Code School"

      assertion.email = "rubymaverick@gmail.com"
      assertion.issued_on = Time.now
      assertion.name = "Completed Level 1 of Ruby Bits"
      assertion.description = "Completed Level 1 of Ruby Bits"
      assertion.badge_url = "http://www.codeschool.com/badges/1"
      assertion.criteria_url = "http://www.codeschool.com/badges/1/criteria"
    end

    it "should produce valid json" do
      subject[:recipient].split("$").first.should == "sha256"
      subject[:recipient].split("$").last.should == digest(assertion.email + subject[:salt])
      subject[:issued_on].should == "2012-08-26"

      badge = subject[:badge]
      badge[:version].should == OpenBadges.version
      badge[:name].should == assertion.name
      badge[:description].should == assertion.description
      badge[:image].should == assertion.badge_url
      badge[:criteria].should == assertion.criteria_url

      issuer = badge[:issuer]
      issuer[:origin].should == OpenBadges.issuer_url
      issuer[:name].should == OpenBadges.issuer_name
    end
  end
end