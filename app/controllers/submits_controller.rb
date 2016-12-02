class SubmitsController < ApplicationController

  def index
    @submits = Submit.all
  end

  def new
    @input = InputModel.create.new(Item.all)
  end

  def create
    @input = InputModel.create.new(Item.all)
    @input.input_attributes = submit_params

    if @input.validate && @input.save
      redirect_to submits_path and return
    else
      render :new
    end
  end

  def edit
    @input = InputModel.create.new(Item.all)

    # submit.idをもとに初期値を代入(この処理はModelのメソッドで実装するほうが良かった)
    @submit_id = params[:id]
    Submit.find(@submit_id).values.each do |value|
      dat = value.send(Item::TYP_TO_FILED_NAME[value.item.typ])
      @input.send("item_#{value.item.id}=", dat)
    end

    render :new
  end

  def update
    @submit_id = params[:id]
    @input = InputModel.create.new(Item.all)
    @input.input_attributes = submit_params

    #　バリデーションに問題がなければ valuesの更新を行う
    if @input.validate
      Submit.find(@submit_id).values.each do |value|
        dat = submit_params["item_#{value.item.id}"]
        value.send("#{Item::TYP_TO_FILED_NAME[value.item.typ]}=", dat)
        value.save
      end
      redirect_to submits_path and return
    end
    render :new
  end

  def show
    @submit = Submit.find(params[:id])
  end

  def submit_params
    permit_attrs = []
    Item.all.each do |item|
      permit_attrs.push("item_#{item.id}".to_sym)
    end
    params.require(:input).permit(permit_attrs)
  end

end