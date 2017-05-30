require 'yaml'
require 'pry'

def load_library(file)
  file_hash = YAML.load_file(file)
  new_hash = { "get_meaning" => {}, "get_emoticon" => {}}

  file_hash.each do |meaning, language|
    index = 0
    while index < language.size
      new_hash["get_emoticon"][language[index]] = language[index+1] if index == 0
      new_hash["get_meaning"][language[index]] = meaning if index == 1
      index += 1
    end
  end
  new_hash

end

def get_japanese_emoticon(file, emoticon)
  emoticon_list = load_library(file)
  jpn_emoticon = nil
  sorry_message = "Sorry, that emoticon was not found"

  emoticon_list["get_emoticon"].each do |eng, jpn|
    jpn_emoticon = jpn if emoticon == eng
  end

  case jpn_emoticon
  when nil then sorry_message
  else jpn_emoticon
  end

end

def get_english_meaning(file, emoticon)
  emoticon_list = load_library(file)
  eng_meaning = nil
  sorry_message = "Sorry, that emoticon was not found"

  emoticon_list["get_meaning"].each do |jpn_emoticon, meaning|
    eng_meaning = meaning if jpn_emoticon == emoticon
  end

  case eng_meaning
  when nil then sorry_message
  else eng_meaning
  end
  
end
