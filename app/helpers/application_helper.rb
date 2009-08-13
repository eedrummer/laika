# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Route helper for test operations.
  def test_operation_url vendor_test_plan, operation
    testop_url vendor_test_plan, vendor_test_plan.test_type, operation
  end

  # Route helper for test setup.
  def test_setup_url patient, test_type_name
    testop_setup_url patient, TestType.get(test_type_name)
  end

  # Return true if +name+ contains the name of the current controller, false otherwise.
  def current_controller?(name)
    controller.controller_name == name.to_s
  end

  # Form helper for building forms using PatientFormBuilder.
  def patient_form_for(record, *args, &proc)
    options = args.extract_options!
    remote_form_for(record, *(args << options.merge(:builder => PatientFormBuilder)), &proc)
  end

  # Return an HTML span describing the requirements for the given model field.
  def requirements_for(model, field)
    return nil unless model.respond_to?(:requirements) and model.requirements
    case model.requirements[field]
      when :required
        '<span class="validation_for required">Required</span>'
      when :hitsp_required
        '<span class="validation_for required">Required (HITSP R)</span>'
      when :hitsp_r2_required
        '<span class="validation_for required">Required (HITSP R2)</span>'
      when :hitsp_optional
        '<span class="validation_for">Optional (HITSP R)</span>'
      when :hitsp_r2_optional
        '<span class="validation_for">Optional (HITSP R2)</span>'
      else
        ''
    end
  end

  # If the file "#{Rails.root}/public/javascripts/#{name}.js" exists, return a javascript
  # include tag that loads this file in the client.
  def javascript_include_if_exists(name, *args)
    if FileTest.exist?(File.join(Rails.root, 'public', 'javascripts', "#{name}.js"))
      javascript_include_tag(name, *args)
    end
  end

end
