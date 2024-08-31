require 'date'

class VehicleFactory
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :vehicle_list

  attr_accessor :registration_date,
                :plate_type

  def initialize
    # @vin = vehicle_details[:vin]
    # @year = vehicle_details[:year]
    # @make = vehicle_details[:make]
    # @model = vehicle_details[:model]
    # @engine = :ev
    # @registration_date = nil
    # @plate_type = nil
    @vehicle_list=[]
  end

  def antique?
    Date.today.year - @year >= 25
  end

  def electric_vehicle?
    @engine == :ev
  end

  def create_vehicles(vehicles)
    #require "pry" ; binding .pry
    @vehicle_list= vehicles.map.with_index do |vehicle_details,index|
        
        vehicle_index = Vehicle.new(vehicle_details)
            #@year= :model_year
    end
    #puts vehicle_list
    #binding.pry
  end

end