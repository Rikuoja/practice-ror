b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042
s1 = Style.create name:"Lager"
s2 = Style.create name:"Pale Ale"
s3 = Style.create name:"Porter"
s4 = Style.create name:"Lager"
b1.beers.create name:"Iso 3", style_id:0
b1.beers.create name:"Karhu", style_id:0
b1.beers.create name:"Tuplahumala", style_id:0
b2.beers.create name:"Huvila Pale Ale", style_id:1
b2.beers.create name:"X Porter", style_id:2
b3.beers.create name:"Hefezeizen", style_id:3
b3.beers.create name:"Helles", style_id:0