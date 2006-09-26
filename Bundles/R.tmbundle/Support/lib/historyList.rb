class HistoryList
  def initialize(string)
    @list = string.split("\n").grep(/^> /).uniq.map{|l| l.gsub(/^> /,"")}
  end
  def next(string)
    if i=@list.index(string)  and i<=@list.length then
      return @list[i+1]
    end
    return nil
  end
  def previous(string)
    if i=@list.index(string) and i>=1 then
      return @list[i-1]
    end
    return nil
  end
end
