class FacilityFactory
    attr_accessor :facility_list
    def initialize
        @facility_list=[]
    end

    def create_facilities(facilities)
        @facility_list= facilities.map.with_index do |facility_details, index|

            facility_index = Facility.new(facility_details)
                 #name = facility_details[:dmv_office]
                # @address = facility_details[:address_li] + " " + facility_details[:city] + " " + facility_details[:state] + " " + facility_details[:zip]
                # @services = facility_details[:services_p]
                # @phone = facility_details[:phone]
                # @registered_vehicles =[]
                # @collected_fees = 0
        end
    end
end