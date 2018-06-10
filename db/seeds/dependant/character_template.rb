Character::Template.create!(
  id:             0,
  name:           'Ada',
  description:    '',
  nature:         Character::Nature.find_by(name: 'Mecha'),
  icon_id:        1,
  picture_id:     1,
  skill_one_id:   1,
  skill_two_id:   2,
  skill_three_id: 3
)
Character::Template.create!(
  id:             1,
  name:           'Nicholas',
  description:    '',
  nature:         Character::Nature.find_by(name: 'Binder'),
  icon_id:        2,
  picture_id:     2,
  skill_one_id:   4,
  skill_two_id:   5,
  skill_three_id: 6
)
Character::Template.create!(
  id:             2,
  name:           'Anaya',
  description:    '',
  nature:         Character::Nature.find_by(name: 'Bender'),
  icon_id:        3,
  picture_id:     3,
  skill_one_id:   7,
  skill_two_id:   8,
  skill_three_id: 9
)
