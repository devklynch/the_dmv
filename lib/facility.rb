class Facility
  attr_accessor :name,
                :address,
                :phone,
                :services,
                :registered_vehicles,
                :collected_fees

  def initialize(facility)
    @name = facility[:name] || facility[:dmv_office] || facility[:office_name] ||  "No Name"
    @address = address_creator(facility)
    @phone = phone_creator(facility)
    @services = services_creator(facility) 
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def address_creator(facility)
    if facility[:address]
       facility[:address]
    elsif facility[:address_li]
      facility[:address_li] + " " + (facility[:address__1] || "") + facility[:city] + " " + facility[:state] + " " + facility[:zip] 
    elsif facility[:street_address_line_1]
      facility[:street_address_line_1] + " " + (facility[:street_address_line_2] || "") + " " + facility[:city] + " " + facility[:state] + " " + facility[:zip_code]
    elsif facility[:address1]
      facility[:address1] + " " + facility[:city] + " " + facility[:state] + " " + facility[:zipcode]
    else
      "No Address"
    end
  end

  def services_creator(facility)
    if facility[:services_p]
      facility[:services_p].split(",")
    else
      []
    end
  end

  def phone_creator(facility)
    if facility[:phone]
      facility[:phone]
    elsif facility[:public_phone_number]
      phone = facility[:public_phone_number]
      "(" + phone[0,3] + ") " + phone[3,3] + "-" + phone[6,4]
    else
      "No Phone Number"
    end
  end

  def register_vehicle(vehicle)
    if vehicle.registration_date == nil
      vehicle.registration_date = Date.today
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
      registrant.license_data[:renewed] = true
    else
      false
    end
  end
end
