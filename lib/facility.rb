class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(facility)
    @name = facility[:name]
    @name = facility[:dmv_office]
    @address = facility[:address]
    @address = facility[:address_li] + " " + facility[:city] + " " + facility[:state] + " " + facility[:zip]
      #+ facility[address__1] + " "
    @phone = facility[:phone]
    @services = []
    @services = facility[:services_p]
    @registered_vehicles =[]
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if vehicle.registration_date == nil
      vehicle.registration_date= Date.today
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
    else
      nil
    end
  end

  def administer_written_test(registrant)
    if @services.include?("Written Test") && registrant.age >= 16 && registrant.permit == true
      registrant.license_data[:written] = true
    else
      false
    end
  end


  def administer_road_test(registrant)
    if @services.include?("Road Test") && registrant.license_data[:written] ==true
      registrant.license_data[:license] = true
    else
      false
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?("Renew License") && registrant.license_data[:license] == true
      registrant.license_data[:renewed] =true
    else
    false
  end
end


end
