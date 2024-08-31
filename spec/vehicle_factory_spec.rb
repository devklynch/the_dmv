require 'spec_helper'

RSpec.describe Vehicle do
  before(:each) do
    @factory=VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    #binding .pry
   @factory.create_vehicles(@wa_ev_registrations)
  end
  describe '#initialize' do
    it 'can initialize' do
        expect(@factory).to be_an_instance_of(VehicleFactory)
    end
  end
  describe '#create vehicles' do
    it 'can create vehicles from a list' do
      expect(@factory.vehicle_list[0]).to be_an_instance_of(Vehicle)
      #expect(@wa_ev_registrations).to be_an_instance_of(DmvDataService)

    end
  end

#   describe '#antique?' do
#     it 'can determine if a vehicle is an antique' do
#       expect(@cruz.antique?).to eq(false)
#       expect(@bolt.antique?).to eq(false)
#       expect(@camaro.antique?).to eq(true)
#     end
#   end

#   describe '#electric_vehicle?' do
#     it 'can determine if a vehicle is an ev' do
#       expect(@cruz.electric_vehicle?).to eq(false)
#       expect(@bolt.electric_vehicle?).to eq(true)
#       expect(@camaro.electric_vehicle?).to eq(false)
#     end
#   end
end
