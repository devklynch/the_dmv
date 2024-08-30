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
    elsif vehicle.antique? == true
      vehicle.plate_type = :antique
    else
      vehicle.plate_type = :regular
    end
    @registered_vehicles << vehicle
  end
end
