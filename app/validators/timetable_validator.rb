class TimetableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    validate_schedule_is_open(record, attribute, value)
    validate_schedule_table_contains_timetable(record, attribute, value)
  end

  private

  def validate_schedule_is_open(record, attribute, value)
    return if schedule_is_open?

    record.errors.add(attribute, :schedule_is_not_open)
  end

  def schedule_is_open?
    Schedule::Checker.new(Time.zone.now).schedule_is_open?
  end

  def validate_schedule_table_contains_timetable(record, attribute, value)
    return if record.errors[attribute].any?
    return if value.present? && schedule_table(value).include?(value)

    record.errors.add(attribute, :timetable_is_out_of_range)
  end

  def schedule_table(massage_date)
    Schedule::TableGenerator.new(massage_date).schedule_table
  end

  #def massage_date
  #  Schedule::MassageDateFinder.new(Time.zone.today).massage_date
  #end
end
