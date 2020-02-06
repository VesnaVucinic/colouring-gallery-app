Picture.delete_all
User.delete_all

vesna = User.create(name: "Vesna", email: "vesna.vucinic68@gmail.com", password: "vesnica")
gudrun = User.create(name: "Gudrun", email: "gudrun.wild@gmail.com", password: "gudruncic")
vicki = User.create(name:"Vicki", email: "vicki.parkin@gmail.com", password: "vickica")

Picture.create(title: "Sleepy Foxy Lady", image_url: "https://i2.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/07/0_IMG_20190707_191454__01-e1562664013295.jpg?fit=640%2C640&ssl=1.jpg", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles", user_id: vesna.id)
Picture.create(title: "My Beautiful Bird", image_url: "https://i0.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/04/IMG_20190428_154722-e1556630932580.jpg?fit=640%2C646&ssl=1.jpg", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles", user_id: vesna.id)
Picture.create(title: "Rainbow Bird", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/04/IMG_20190424_084716-e1556630862218.jpg?fit=640%2C638&ssl=1.jpg", description: "Colouring book: Beautiful Birds and Treetop Treasures by Millie Marotta. Material used: Faber Castell Polichromos penciles", user_id: vesna.id)
Picture.create(title: "Gorgeus", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/10/MM-WS-Bushshrike-Gorgeous-4Colour-F01.jpg?fit=640%2C655&ssl=1", description: "Colouring book: Wild Savannah by Millie Marotta. Material used: Colleen pencils, Stabilo fineliners", user_id: vicki.id)
Picture.create(title: "Butterflies", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/08/IMG_20190721_175126__01.jpg?fit=640%2C702&ssl=1.jpg", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles", user_id: vesna.id)
Picture.create(title: "Rabbit", image_url: "https://i2.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/06/Hase.jpg?fit=640%2C646&ssl=1.jpg", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell, Polichromos Künstlerfrbstifte, Copic Multiliner", user_id: gudrun.id)
Picture.create(title: "Very Handsome Rooster", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/08/IMG_20190721_175113__01.jpg?fit=640%2C748&ssl=1.jpg", description: "Colouring book: Annimal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles", user_id: vesna.id)
Picture.create(title: "Pink Sky", image_url: "https://i2.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/08/IMG_20190804_163829__01__01__01.jpg?fit=640%2C333&ssl=1", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles,silver glittery pen and pastels", user_id: vesna.id)
Picture.create(title: "Lizard", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/06/MM-WS-Frill-Neck-Lizard-F01.jpg?fit=640%2C658&ssl=1", description: "Colouring book: Wild Savannah by Millie Marotta. Material used: Koh-i-Noor Magic + Polycolor Pencils", user_id: gudrun.id)
Picture.create(title: "Blue Bird", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/07/IMG_20190721_173710__01.jpg?fit=640%2C731&ssl=1.jpg", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles", user_id: vesna.id)
Picture.create(title: "Very Cute Bird", image_url: "https://i1.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/07/IMG_20190724_064847__01.jpg?fit=640%2C686&ssl=1.jpg", description: "Colouring book: Animal Kingdom by Millie Marotta. Material used: Faber Castell Polichromos penciles and pastels", user_id: vesna.id)
Picture.create(title: "Toucan", image_url: "https://i2.wp.com/milliemarotta.co.uk/wp-content/uploads/2019/08/Toucan.jpg?fit=640%2C642&ssl=1", description: "Colouring book: Tropical Wonderland by Millie Marotta. Material used: Pencils, black posca and gold gel pen", user_id: vicki.id)
