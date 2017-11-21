use NFL
db.NFL.find({}).limit(10).comment("Test if DB loaded properly");

db.NFL.aggregate(
   [
     { $match: { "PlayType": "Run", "yrdln": "20", $comment: "Test aggregate query"} },
     { $group: { "_id": "$DefensiveTeam" , "count": { $sum: 1 } } }
   ]
);

db.NFL.aggregate(
	[
		{ $match: { "Yards.Gained": { $gt: 0 }, "Touchdown": { $gt: 0 }, $comment: "Find all plays that scored a touchdown with positive yard gains, grouping by team and count the plays per team, sorted in alphabetical order." } },
		{ $group: { "_id": "$posteam" , "count": { $sum: 1 } } },
		{ $sort: { _id: 1} }
	]
);

db.NFL.aggregate(
   [
     {
       $group:
         {
           _id: "$posteam",
           ydsGainAvg: { $avg: "$Yards.Gained" },
           tdsAvg: { $avg: "$Touchdown" }
         }
     }
   ]
);