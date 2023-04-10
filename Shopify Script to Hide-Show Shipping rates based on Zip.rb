# ================================ Customizable Settings ================================
# ================================================================
# Hide/Show Rate(s) for Zip/Country
#
# If the cart's shipping address country/zip match the
# entered settings, the entered rate(s) are hidden/shown.
#
#   - 'country_code' is a 2-character abbreviation for the
#     applicable country or region
#   - 'province_code' is a list of 2-character abbreviations for
#     the applicable provinces or states
#   - 'zip_code_match_type' determines whether the below strings
#     should be an exact or partial match. Can be:
#       - ':exact' for an exact match
#       - ':partial' for a partial match
#       - ':start_with' to check if starts with a specified prefix
#   - 'zip_codes' is a list of strings to identify zip codes
#   - 'rate_match_type' determines whether the below strings
#     should be an exact or partial match. Can be:
#       - ':exact' for an exact match
#       - ':partial' for a partial match
#       - ':all' for all rates
#   - 'rate_names' is a list of strings to identify rates
#     - if using ':all' above, this can be set to 'nil'
# ================================================================
HIDE_SHOW_RATES_FOR_ZIP_PROVINCE_COUNTRY = [
  {
    country_code: "CA",
    zip_code_match_type: :start_with,
    zip_codes: ["A0K","A0P","A0R","A2V","G0G","G4T","J0M","R0B","T0P","T0V","V0L","V0T","V0V","V0W","X0A","X0B","X0C","X0E","X0G","X1A","X1O","Y0A","Y0B","Y1A","Y1O"],
    rate_match_type: :exact,
    rate_codes: ["Free Standard Shipping - Canada (7-12 days)","Premium Shipping - Canada","Outside Delivery Area (ODA) Surcharge"],
    rate_message: "[FedEx has a mandatory Out-of-Delivery Area surcharge for your shipping zip code!]",
    surcharge_rate_codes: ["Outside Delivery Area [ODA] Surcharge"],
  },
  {
    country_code: "CA",
    zip_code_match_type: :start_with,
    zip_codes: ["A0A","A0B","A0C","A0E","A0G","A0H","A0J","A0L","A0M","A0N","A1S","A1V","A1W","A1X","A1Y","A2A","A2B","A2H","A2V","A5A","A8A","B0H","E0G","E0L","E2H","E3C","E3L","E3N","E4A","E4B","E4C","E4L","E4S","E4T","E4Z","E5A","E5E","E5G","E5M","E5N","E5R","E5T","E5V","E6A","E6B","E6E","E6G","E6H","E6J","E6K","E7A","E7C","E7G","E7H","E7J","E7K","E7M","E7N","E7V","E8A","E8B","E9A","E9B","E9C","E9E","E9G","G0A","G0B","G0C","G0E","G0H","G0J","G0K","G0L","G0M","G0N","G0P","G0R","G0S","G0T","G0V","G0W","G0X","G0Y","G0Z","G3G","G3H","G3J","G3K","G3L","G3Z","G4A","G4R","G4S","G4V","G4W","G4X","G4Z","G5A","G5B","G5C","G5H","G5J","G5L","G5M","G5N","G5R","G5T","G5V","G6B","G6L","G7B","G7N","G7P","G8B","G8C","G8E","G8G","G8H","G8J","G8K","G8L","G8M","G8N","G8P","G9X","H0M","J0A","J0B","J0C","J0E","J0G","J0H","J0J","J0K","J0L","J0S","J0T","J0V","J0W","J0X","J0Y","J0Z","J1A","J1T","J5X","J8G","J8L","J8M","J8N","J9B","J9E","J9L","J9P","J9T","J9X","J9Y","J9Z","K0A","K0C","K0E","K0G","K0J","K0M","L0A","L0B","L0C","N0K","N0L","P0A","P0B","P0C","P0E","P0G","P0H","P0J","P0K","P0L","P0M","P0N","P0P","P0R","P0S","P0T","P0V","P0W","P0X","P0Y","P5A","P5E","P5N","P8T","P9A","P9N","R0A","R0C","R0E","R0G","R0H","R0J","R0K","R0L","R0M","R4H","R4J","R4K","R4L","R5A","R5G","R6M","R6W","R7N","R8A","R8N","R9A","S0A","S0C","S0E","S0G","S0H","S0J","S0K","S0L","S0M","S0N","S0P","S2V","S4A","S4H","S9X","T0A","T0B","T0C","T0E","T0G","T0H","T0J","T0K","T0L","T0M","T1G","T1M","T1O","T1P","T1V","T4J","T4T","T7A","T7E","T7N","T7P","T7S","T7V","T8R","T8S","T9C","T9M","T9N","T9S","T9W","T9X","V0A","V0B","V0C","V0E","V0G","V0J","V0K","V0M","V0N","V0P","V0R","V0S","V0X","V1G","V1H","V1J","V1K","V1L","V1N","V1R","V2G","V2J","V8A","V8C","V8G","V8J","V8K","V9G","V9J","V9K"],
    rate_match_type: :exact,
    rate_codes: ["Free Standard Shipping - Canada (7-12 days)","Premium Shipping - Canada","Outside Delivery Area [ODA] Surcharge"],
    rate_message: "[FedEx has a mandatory Out-of-Delivery Area surcharge for your shipping zip code!]",
    surcharge_rate_codes: ["Outside Delivery Area (ODA) Surcharge"],
  }
]

# ================================ Script Code (do not edit) ================================
# ================================================================
# ZipCodeSelector
#
# Finds whether the supplied zip code matches any of the entered
# strings.
# ================================================================
class ZipCodeSelector
  def initialize(match_type, zip_codes)
    @match_type = match_type
    @comparator = match_type == :exact ? '==' : 'include?'
    @zip_codes = zip_codes.map { |zip_code| zip_code.upcase.strip }
  end
  
  def match?(zip_code)
    if @match_type == :start_with
      @comparator = 'start_with?'
    end
    @zip_codes.any? { |zip| zip_code.to_s.upcase.strip.send(@comparator, zip) }
  end
end

# ================================================================
# RateCodeSelector
#
# Finds whether the supplied rate code matches any of the entered
# names.
# ================================================================
class RateCodeSelector
  def initialize(match_type, rate_codes)
    @match_type = match_type
    @comparator = match_type == :exact ? '==' : 'include?'
    @rate_codes = rate_codes&.map { |rate_code| rate_code.downcase.strip }
  end

  def match?(shipping_rate)
    if @match_type == :all
      true
    else
      @rate_codes.any? { |code| shipping_rate.code.downcase.send(@comparator, code) }
    end
  end
end

# ================================================================
# HideShowRatesForZipProvinceCountryCampaign
#
# If the cart's shipping address zip/country match the
# entered settings, the entered rate(s) are hidden/shown.
# ================================================================
class HideShowRatesForZipProvinceCountryCampaign
  def initialize(campaigns)
    @campaigns = campaigns
  end

  def run(cart, shipping_rates)
    address = cart.shipping_address

    return if address.nil?

    @campaigns.each do |campaign|
      zip_code_selector = ZipCodeSelector.new(campaign[:zip_code_match_type], campaign[:zip_codes])
      country_match =  address.country_code.upcase.strip == campaign[:country_code].upcase.strip
      zip_match = zip_code_selector.match?(address.zip)

      if country_match && zip_match
        rate_code_selector = RateCodeSelector.new(campaign[:rate_match_type], campaign[:rate_codes])
        shipping_rates.delete_if do |shipping_rate|
          rate_code_selector.match?(shipping_rate)
        end
        
        # Change surcharge rate code's name to show proper message
        surcharge_rate_code_selector = RateCodeSelector.new(campaign[:rate_match_type], campaign[:surcharge_rate_codes])
        shipping_rates.each do |shipping_rate|
          next unless surcharge_rate_code_selector.match?(shipping_rate)
          rate_name = shipping_rate.name + ' ' + campaign[:rate_message]
          shipping_rate.change_name(rate_name)
        end
      elsif country_match && !zip_match
        rate_code_selector = RateCodeSelector.new(campaign[:rate_match_type], campaign[:surcharge_rate_codes])
        shipping_rates.delete_if do |shipping_rate|
          rate_code_selector.match?(shipping_rate)
        end
      end
    end
  end
end

CAMPAIGNS = [
  HideShowRatesForZipProvinceCountryCampaign.new(HIDE_SHOW_RATES_FOR_ZIP_PROVINCE_COUNTRY),
]

CAMPAIGNS.each do |campaign|
  campaign.run(Input.cart, Input.shipping_rates)
end

Output.shipping_rates = Input.shipping_rates


