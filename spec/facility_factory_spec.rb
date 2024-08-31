require 'spec_helper'

RSpec.describe FacilityFactory do
describe 'can import for other statues' do
    it 'can import CO offices' do
      @fac_factory=FacilityFactory.new
      @colorado_facilities =DmvDataService.new.co_dmv_office_locations

      @fac_factory.create_facilities(@colorado_facilities)

      expect(@fac_factory).to be_an_instance_of(FacilityFactory)
      expect(@fac_factory.facility_list[0]).to be_an_instance_of(Facility)

      #binding.pry
    end
  end
end