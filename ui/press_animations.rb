require 'yaml'

data = YAML.load_file 'control_settings/ui.yaml'

sequences_press = {}
# puts data['sequences']
data['sequences']
  .filter { |key, _sequence| key.start_with? 'key_' and !key.end_with? 'press' }
  .each do |key, sequence|
    virtual_key_code = ''

    abc = data['control_settings']['keyboard']['layout_positions']['us']
      .find { |_virtual_key, value| value['sequence'] == key }
    virtual_key_code = abc.first unless abc.nil?

    sprite_index = sequence['frames'][0]['sprite']['index']
    sequences_press["#{key}_press"] = {
      'next' => key,
      'input_reactions' => { 'press_button' => { 'button' => { 'Key' => virtual_key_code }, 'next' => "#{key}_press" } },
      'frames' => [
        { 'wait' => 1, 'sprite' => { 'sheet' => 1, 'index' => sprite_index + 8 }, 'scale' => 2.0 },
        { 'wait' => 1, 'sprite' => { 'sheet' => 1, 'index' => sprite_index + 192 }, 'scale' => 2.0 },
        { 'wait' => 1, 'sprite' => { 'sheet' => 1, 'index' => sprite_index + 200 }, 'scale' => 2.0 },
        { 'wait' => 1, 'sprite' => { 'sheet' => 1, 'index' => sprite_index + 192 }, 'scale' => 2.0 },
        { 'wait' => 1, 'sprite' => { 'sheet' => 1, 'index' => sprite_index + 8 }, 'scale' => 2.0 },
      ]
    }
  end

sequences_with_buttons = data['sequences']
  .filter { |key, _sequence| key.start_with? 'key_' and !key.end_with? 'press' }
# puts YAML.dump sequences_with_buttons

mixed_sequences = sequences_with_buttons.to_a.zip(sequences_press.to_a).to_h

# puts mixed_sequences
puts YAML.dump mixed_sequences

# puts YAML.dump data
