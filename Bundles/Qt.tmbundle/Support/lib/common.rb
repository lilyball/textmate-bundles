def signature_to_arguments(signature)
  sig = signature_to_implementation_signature(signature)
  if sig =~ /\((.+)\)/
    $1.split(",").map do |e|
      e.split(" ")[-1].gsub(/[*&]/, '')
    end.join(", ")
  else
    ""
  end
end

def signature_to_implementation_signature(signature)
  if signature =~ /\((.*)\)(.*)$/
    suffix = $2.strip
    signature = $1.split(",").map do |a|
      a.gsub(/\s+/, " ").gsub(/=.+/, "").strip
    end.join(", ")

    "(#{signature}) #{suffix}".strip
  else
    ""
  end
end

def closest_tag(tags, line_number)
  tag = nil
  tags.each do |t|
    next if (line_number - t.line) < 0
    tag = t if tag.nil? || (line_number - t.line) < (line_number - tag.line)
  end
  return tag
end

def temp_file(name)
  temp = `mktemp -t #{name}`.chomp
  File.delete(temp)
  return temp
end