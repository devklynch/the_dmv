class FacilityFactory
    attr_accessor :facility_list
    def initialize
        @facility_list=[]
    end

    def create_facilities(facilities)
        @facility_list= facilities.map.with_index do |facility_details, index|

            facility_index = Facility.new(facility_details)
        end
    end
end