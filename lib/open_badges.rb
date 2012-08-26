require "open_badges/version"
require "open_badges/assertion"
require "active_support/core_ext"

module OpenBadges
  mattr_accessor :issuer_url
  mattr_accessor :issuer_name
  mattr_accessor :issuer_org
  mattr_accessor :issuer_contact
  mattr_accessor :version
  self.version = "0.5.0"
  mattr_accessor :salt
end
