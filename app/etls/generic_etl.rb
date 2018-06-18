require 'csv'

class GenericETL
  def load!(model)
    puts "Seeding #{model.model_name}..."
    file = Rails.root.join("db/seeds/#{model.model_name.plural}.csv")
    i = 0
    CSV.foreach(file, headers: true, col_sep: ";") do |row|
      obj = find_obj(model, row)
      i += 1 unless obj.changes.empty?
      obj.save!
    end
    puts "Done. #{i} rows affected"
  end

  def find_obj(model, row)
    obj = model.find_or_initialize_by(name: row['name'])
    obj.attributes = row.to_h.symbolize_keys
    obj
  end
end