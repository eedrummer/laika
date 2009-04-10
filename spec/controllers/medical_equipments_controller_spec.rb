require File.dirname(__FILE__) + '/../spec_helper'

describe MedicalEquipmentsController do
  fixtures :patient_data, :medical_equipments

  before do
    @user = stub(:user)
    controller.stub!(:current_user).and_return(@user)
    @patient_data = patient_data(:joe_smith)
  end

  it "should assign @medical_equipment on get new" do
    get :new, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:medical_equipment].should be_new_record
  end

  it "should render edit template on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.medical_equipments.first.id.to_s
    response.should render_template('medical_equipments/edit')
  end

  it "should assign @medical_equipment on get edit" do
    get :edit, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.medical_equipments.first.id.to_s
    assigns[:medical_equipment].should == @patient_data.medical_equipments.first
  end

  it "should render create template on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    response.should render_template('medical_equipments/create')
  end

  it "should assign @medical_equipment on post create" do
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    assigns[:medical_equipment].should_not be_new_record
  end

  it "should add an medical_equipment on post create" do
    old_medical_equipment_count = @patient_data.medical_equipments.count
    post :create, :patient_data_instance_id => @patient_data.id.to_s
    @patient_data.medical_equipments(true).count.should == old_medical_equipment_count + 1
  end

  it "should render show partial on put update" do
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => @patient_data.medical_equipments.first.id.to_s
    response.should render_template('medical_equipments/_show')
  end

  it "should update medical_equipment on put update" do
    existing_medical_equipment = @patient_data.medical_equipments.first
    put :update, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_medical_equipment.id.to_s, :medical_equipment => { :name => 'foobar'}
    existing_medical_equipment.reload
    existing_medical_equipment.name.should == 'foobar'
  end

  it "should remove from @patient_data.medical_equipments on delete destroy" do
    existing_medical_equipment = @patient_data.medical_equipments.first
    delete :destroy, :patient_data_instance_id => @patient_data.id.to_s, :id => existing_medical_equipment.id.to_s
    @patient_data.medical_equipments(true).should_not include(existing_medical_equipment)
  end

end

