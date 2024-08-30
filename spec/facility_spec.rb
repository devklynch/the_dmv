require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 16 )
    @registrant_3 = Registrant.new('Tucker', 15 )

  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register vehicle' do
    it 'can register a car' do
      expect(@facility_1.registered_vehicles.count).to eq(0)
      expect(@cruz.registration_date).to eq(nil)
      expect(@cruz.plate_type).to eq(nil)
      expect(@facility_1.collected_fees).to eq(0)

     @facility_1.register_vehicle(@cruz)
     expect(@cruz.plate_type).to eq(:regular)
     expect(@cruz.registration_date.class).to eq(Date)
     expect(@facility_1.collected_fees).to eq(100)

     @facility_1.register_vehicle(@bolt)
     expect(@bolt.plate_type).to eq(:ev)
     expect(@facility_1.collected_fees).to eq(300
     )
     @facility_1.register_vehicle(@camaro)
  
      expect(@facility_1.registered_vehicles.count).to eq(3)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@facility_1.collected_fees).to eq(325)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.services).to eq([])
      expect(@facility_2.register_vehicle(@bolt)).to eq(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)
    end

  end

  describe '#administer written test' do
  it 'can give a written test to registrants' do
    expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
    expect(@registrant_1.license_data[:written]).to eq(false)

   @facility_1.add_service("Written Test")

    expect(@facility_1.administer_written_test(@registrant_1)).to eq(true)
    expect(@registrant_1.license_data[:written]).to eq(true)
  end

  it 'prevents registrants under 16 or do not have a permit' do
    @facility_1.add_service("Written Test")

    expect(@facility_1.administer_written_test(@registrant_2)).to eq(false)

    @registrant_2.earn_permit

    expect(@facility_1.administer_written_test(@registrant_2)).to eq(true)

    @registrant_3.earn_permit
    expect(@facility_1.administer_written_test(@registrant_3)).to eq(false)
end
end

  describe '#administer road test' do
  it'gives a license once completing the road test' do
    expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
    expect(@registrant_1.license_data[:license]).to eq(false)

   @facility_1.add_service("Road Test")
   @facility_1.add_service("Written Test")

   expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)

   @facility_1.administer_written_test(@registrant_1)
  #require "pry" ; binding .pry
   expect(@registrant_1.license_data[:written]).to eq(true)

   expect(@facility_1.administer_road_test(@registrant_1)).to eq(true)

   
  end
  end
#last end
end
