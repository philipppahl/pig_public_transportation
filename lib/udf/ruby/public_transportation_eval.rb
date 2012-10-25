require 'pigudf'

class PublicTransportationEval < PigUdf

  outputSchema "hour:long"
  def hour(time)
    df = java.text.SimpleDateFormat.new("yyyy-MM-dd' 'HH:mm:ss' '+SSSS")
    df.parse(time).getHours
  end
  
  outputSchema "number:double"
  def round(number, digits)
    number.round(digits)
  end

end

