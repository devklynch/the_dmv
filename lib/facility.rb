class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(facility)
    @name = facility[:name]
    @address = facility[:address]
    @phone = facility[:phone]
    @services = []
    @registered_vehicles =[]
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    vehicle.registration_date=Time.now
    if vehicle.engine == :ev
      vehicle.plate_type = :ev
      @collected_fees += 200
    elsif vehicle.antique? == true
      vehicle.plate_type = :antique
      @collected_fees += 25
    else
      vehicle.plate_type = :regular
      @collected_fees += 100
    end
    @registered_vehicles << vehicle
  end
end
