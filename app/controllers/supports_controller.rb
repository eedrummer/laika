class SupportsController < PatientDataChildController

  def edit
    @support = @patient_data.support
  end

  def create
    support = Support.new(params[:support])
    @patient_data.support = support
    support.create_person_attributes(params)
    render :partial  => 'show', :locals => {:support =>  support,
                                            :patient_data => @patient_data}
  end

  def update
    support = @patient_data.support

    support.update_attributes(params[:support])
    support.update_person_attributes(params)

    render :partial  => 'show', :locals => {:support =>  support,
                                            :patient_data => @patient_data}
  end

  def destroy
    support = @patient_data.support
    support.destroy
    render :partial  => 'show', :locals => {:support =>  nil,
                                            :patient_data => @patient_data}
                                                
  end
  
end
