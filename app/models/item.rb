class Item < ApplicationRecord
  TYP_STING = 1
  TYP_NUMBER = 2
  TYP_DATETIME = 3

  TYP_SELECT = [
      ['文字', TYP_STING],
      ['数字', TYP_NUMBER],
      ['日時', TYP_DATETIME]
  ]

  TYP_TO_FILED_NAME = {
      TYP_STING => 'str',
      TYP_NUMBER => 'int',
      TYP_DATETIME =>'datetime'
  }

  BOOLEAN_SELECT = [
      ['No', false],
      ['Yes', true]
  ]

  has_one :value
end
