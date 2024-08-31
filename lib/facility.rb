class Facility
  attr_accessor :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(facility)
    @name = facility[:name] || facility[:dmv_office] || facility[:office_name] ||  "None Name"
   # @name = facility[:dmv_office]

   #@address = facility[:address_li] + " " + facility[:city] + " " + facility[:state] + " " + facility[:zip]
      #+ facility[address__1] + " "
    @address = address_creator(facility)
    @phone = facility[:phone] || facility[:public_phone_number]
    @services = facility[:services_p]|| []
   # @services = facility[:services_p]
    @registered_vehicles =[]
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def address_creator(facility)
    if facility[:address]
       facility[:address]
    elsif facility[:address_li]
      facility[:address_li] + " " + facility[:city] + " " + facility[:state] + " " + facility[:zip] 

    elsif facility[:address_line_1]
      facility[:address_line_1] + " " + facility[:city] + " " + facility[:state] + " " + facility[:zip_code]
    elsif facility[:address1]
      facility[:address1] + " " + facility[:city] + " " + facility[:state] + " " + facility[:zipcode]
    else
    "No Address"
  end
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
