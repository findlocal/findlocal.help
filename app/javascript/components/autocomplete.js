const locationMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, locationRegex;

    matches = [];

    locationRegex = new RegExp(q, 'i');

    
    $.each(strs, function(i, str) {
      if (locationRegex.test(str)) {
        matches.push(str);
      }
    });

    cb(matches);
  };
};

const location_list = (:location)

$('#location-search.typeahead').typeahead({
  hint: true,
  highlight: true,
  minLength: 1
},
{
  name: 'location-list',
  source: locationMatcher(location)
});

const tagMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches_tag, tagRegex;

    matches_tag = [];

    tagRegex = new RegExp(q, 'i');

    
    $.each(strs, function(i, str) {
      if (tagRegex.test(str)) {
        matches_tag.push(str);
      }
    });

    cb(matches_tag);
  };
};

const tags_list = (tag:)

$('#tags-search.typeahead').typeahead({
  hint: true,
  highlight: true,
  minLength: 1
},
{
  name: 'tags-list',
  source: tagMatcher(tag)
});

