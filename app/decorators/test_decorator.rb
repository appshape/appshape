class TestDecorator < Draper::Decorator
  delegate_all

  def label_class
    object.active ? 'label-primary' : 'label-danger'
  end

  def label_text
    object.active ? I18n.t('label_active') : I18n.t('label_inactive')
  end

  def toggle_test_icon
    object.active ? 'fa-stop' : 'fa-play'
  end

  def toggle_test_text
    object.active ? I18n.t('label_disable') : I18n.t('label_enable')
  end
end