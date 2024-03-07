# frozen_string_literal: true

class ThemeSettingsManager::Objects < ThemeSettingsManager
  def value
    has_record? ? db_record.json_value : default.map!(&:deep_stringify_keys)
  end

  def value=(objects)
    ensure_is_valid_value!(objects)
    record = has_record? ? update_record!(json_value: objects) : create_record!(json_value: objects)
    theme.reload
    record.json_value
  end

  def schema
    @opts[:schema]
  end
end
