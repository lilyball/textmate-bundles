def signature_to_arguments(signature)
  sig = signature_to_implementation_signature(signature)
  sig.split(",").map do |e|
    e.split(" ")[-1]
  end.join(", ")
end

def signature_to_implementation_signature(signature)
  if signature =~ /\((.+)\)/
    signature = $1
    signature.split(",").map do |a|
      a.gsub(/\s+/, " ").gsub(/=.+/, "").strip
    end.join(", ")
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
