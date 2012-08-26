require 'digest'
require 'securerandom'

module OpenBadges
  class Assertion
    attr_accessor :email, :issued_on, :name, :description,
                    :badge_url, :criteria_url

    def as_json options={}
      {
        recipient: recipient,
        salt: salt,
        issued_on: issued_on,
        badge: {
          version: OpenBadges.version,
          name: self.name,
          image: self.badge_url,
          description: self.description,
          criteria: criteria_url,
          issuer: {
            origin: OpenBadges.issuer_url,
            name: OpenBadges.issuer_name,
            org: OpenBadges.issuer_org,
            contact: OpenBadges.issuer_contact
          }
        }
      }
    end

    private

    def recipient
      "sha256$#{Digest::SHA256.hexdigest(self.email + salt)}"
    end

    def salt
      @salt ||= SecureRandom.hex
    end

    def issued_on
      @issued_on.strftime("%Y-%m-%d")
    end
  end
end