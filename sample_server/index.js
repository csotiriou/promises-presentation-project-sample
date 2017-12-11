const express = require('express');
const sampleJson = require('./json/categoryarticles.json')
const app = express();
const _ = require('lodash');

function generateSampleArticles() {
	let articlesArray = [];
	for (let i = 0; i<100; i++) {
		articlesArray.push({
			title : 'title ' + i,
			summary : 'summary' + i,
			content : 'this is a sample article content' + i
		})
	}
	return articlesArray;
}

app.get('/api/articles', function(req, res) {
	let response = generateSampleArticles();

	if (req.query['category']) {
		response = response.map(article => {
			return Object.assign({category : req.query['category']}, article)
		})
	}
	
	res.jsonp(response)
});

app.get('/api/error', function(req, res) {
  res.status(500).end()
});


app.get('/api/categories', function(req, res) {
	let categories = [];
	for (let i = 0; i<100; i++) {
		categories.push({name : 'category' + i, id : i})
	}
	res.jsonp(categories);
});

app.listen(3000);