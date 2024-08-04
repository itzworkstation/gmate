# frozen_string_literal: true

Rails.application.config.after_initialize do
  class BaseConfigSeed
    def import
      base_config_yml.fetch('Category', {}).each_value do |category_hash|
        category_obj = Category.find_or_initialize_by(slug: category_hash['slug'])
        category_obj.name = category_hash['name']
        category_obj.is_active = category_hash['is_active'] unless category_hash['is_active'].nil?
        save_object(category_obj)
        #---------Subcategories -----------------------------
        category_hash['sub_categories'].each_value do |sub_category_hash|
          scg_obj = category_obj.sub_categories.find_or_initialize_by(slug: sub_category_hash['slug'])
          scg_obj.name = sub_category_hash['name']
          scg_obj.is_active = sub_category_hash['is_active'] unless sub_category_hash['is_active'].nil?
          save_object(scg_obj)
        end
      end
    rescue StandardError => e
      Rails.logger.info "The error in setting up the base data : #{e.message}"
    end

    private

    def save_object(model_object)
      if model_object.changed? && model_object.valid?
        model_object.save
      elsif model_object.invalid?
        Rails.logger.info "The error in object #{model_object.model_name.name}: #{model_object.errors.full_messages}"
      end
    end

    def base_config_yml
      YAML.load_file("#{Rails.root}/config/base_config.yml")
    end
  end
  BaseConfigSeed.new.import
end
