class CharacterTemplateETL < GenericETL

  def find_obj(model, row)
    attr = row.to_h.symbolize_keys
    obj = model.find_or_initialize_by(name: attr[:name])
    obj.attributes = attr.except(:nature)
    obj.nature = Character::Nature.find_by(name: attr[:nature])
    obj
  end
end
