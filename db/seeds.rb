Mystery.destroy_all
User.destroy_all

User.create!(username: 'Janek', email: 'a@a.a', password: '12345678')
user = User.create!(username: 'test', email: 'test@example.com', password: '12345678')

10.times do |index|
  Mystery.create!(name: "Mystery no. #{index + 1}",
               description: 'Sed dolor mi, congue ut dolor ac, eleifend ornare est. Donec nisl arcu, condimentum id
                             finibus id, tempus in eros. Duis vitae tempus massa. Sed lorem mi, convallis nec porta id,
                             tristique non magna. Phasellus nec bibendum lorem. Proin rhoncus egestas pellentesque.
                             Vivamus ultricies eu arcu molestie tristique. Suspendisse potenti. In blandit odio ornare,
                             semper magna nec, lobortis enim.',
               is_published: (index % 5 < 4),
               is_solved: (index % 5 < 1),
               admin: user)
end
