require File.join(File.dirname(__FILE__),"GTD.rb")
def html_actions_for_context(context)
  actions = GTDFile.actions_for_context(context)
  pr = Printer.new
  str=<<EOS
      <style> table {
        border:2px;
        border-color:red;
      }
      </style>
EOS
  pr.raw str
  pr.table do
    pr.title("Actions for context: #{context}")
    pr.headers(["Action name","Project","Due_by"])
    actions.each do |a|
      proj = if a.project != nil then a.project.link else "none" end
      due = case a.due
        when "",nil
          ""
        when DateLate
          "<span style=\"color:red\">#{a.due}</span>"
        else
          a.due
      end
      pr.row([a.link,proj,due])
    end
  return pr.to_html
  #.to_html
  end
  # ar << "<div>"
  # ar << "<h1>Actions for context: #{context}</h1>"
end

def prettify(array)
  # pp array
  return "" if array.nil? || array.empty?
  ar = []
  columns = array[0].zip(*array[1..-1])
  # pp columns
  maxs = columns.map{|c| c.map{|i| i.length}.max}
  maxs[2] = 10
  # puts maxs
  pattern = "| "+maxs.map{|m| "%-#{m}s"}.join(" | ")+" |"
  slider = "+-" + maxs.map{|m| "-" * m}.join("-+-")+"-+"
  # print pattern
  ar << slider
  ar << sprintf(pattern,"Action","Project","Due by")
  ar << slider
  array.each {|i| ar << sprintf(pattern,*i)}
  ar << slider
  return ar.join("\n")
end

