module UsersHelper
  def sayHello
    time = Time.new.seconds_since_midnight
    case time
    when 0..(60*60*7)
        'Que Madrugon'
      when 0..(60*60*12)
        'Buenos Días'
      when (60 * 60 * 12)..(60 * 60 * 18)
        'Buenas Tardes'
      else
        'Buenas Noches'
    end
  end

end
