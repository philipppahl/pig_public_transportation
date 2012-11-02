require 'pigudf'

class PublicTransportationEval < PigUdf

  outputSchema "hour:long"
  def hour(time)
    df = java.text.SimpleDateFormat.new("yyyy-MM-dd' 'HH:mm:ss' '+SSSS")
    df.parse(time).getHours
  end
  
  outputSchema "utime:long"
  def utime(time)
    df = java.text.SimpleDateFormat.new("yyyy-MM-dd' 'HH:mm:ss' '+SSSS")
    df.parse(time).getTime / 1000
  end
  
  outputSchema "number:double"
  def round(number, digits)
    number.round(digits)
  end

  outputSchema "rides:{t:(duration:long)}"
  def rides(times_bag)
    times = times_bag.to_a.map(&:first).sort
    (0..times.size-2).reduce(DataBag.new){|r, i|
      gap = times[i+1] - times[i]
      r.add( [gap] ) if gap > (3 * 60)
      r
    }
  end
  
end

