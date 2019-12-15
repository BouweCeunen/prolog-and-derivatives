preference(john,whiskey,like_little).
preference(john,gin,like_little).
preference(john,lager,like_much).
preference(mary,whiskey,like_verymuch).
preference(mary,redwine,like_much).
preference(peter,whiskey,like_much).
preference(peter,stout,like_much).
preference(peter,whitewine,like_no).
preference(paul,whiskey,like_no).
preference(paul,coffee,like_verymuch).
preference(ann,gin,like_verymuch).
preference(ann,lager,like_little).
0.0::buy(Person,Beverage) :- preference(Person,Beverage,like_no).
0.1::buy(Person,Beverage) :-
    preference(Person,Beverage,like_little).
0.5::buy(Person,Beverage) :-
    preference(Person,Beverage,like_much).
0.9::buy(Person,Beverage) :-
    preference(Person,Beverage,like_verymuch).
query(buy(Person,whiskey)).