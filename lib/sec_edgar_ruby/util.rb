module SecEdgarRuby
  class Util
    # except_mapping just use for level 1 keys
    # except_mapping = { 'old_key': 'new_key' }
    def self.deep_snake_case_keys(hash, except_mapping = {})
      return hash unless hash.is_a?(Hash)
      return hash if hash.blank?

      result = hash.deep_transform_keys { |key| key.to_s.underscore.to_sym }

      except_mapping.each do |key, value|
        result[:"#{value}"] = result.delete :"#{key}" if result.keys.include? key
      end

      result
    end
  end
end
