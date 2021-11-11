const databases = {
  _meta: {
     total: 123,
     found: 12
 },
 data:  [
   {
     id: 1,
     title: "Database 1",
     alternate_titles: ["Database one"],
     description: "21st Century Sociology: A Reference Handbook provides a concise forum through which the vast array of knowledge accumulated, particularly during the past three decades, can be organized into a single definitive resource. The two volumes of this Reference Handbook focus on the corpus of knowledge garnered in traditional areas of sociological inquiry, as well as document the general orientation of the newer and currently emerging areas of sociological inquiry.",
     urls: [{title: 'link text', url: 'http://www.ub.gu.se'}],
     public_access: false,
     access_information_code: "free",
     publishers: ['SAGE'],
     media_types: [{id: 1, name: "multimedia"}],
     topics: [{id:11, name: "Economic history"}],
     topics_recommended: [{id:11, name: "Economic history"}],
     is_recommended: true,
     malfunction_message_active: false,
     malfunction_message: 'down for maintenance',
     terms_of_use: [
       {id:1, code: "print_article_chapter", description: null, permitted: true},
       {id:2, code: "download_article_chapter", description: null, permitted: false},
       {id:3, code: "course_pack_print", description: null, permitted: true},
       {id:4, code: "gul_course_pack_electronic", description: null, permitted: true},
       {id:6, code: "scholarly_sharing", description: null, permitted: true},
       {id:7, code: "interlibrary_loan", description: "ILL print, fax or secure electronic transmission: Permitted", permitted: true},
     ]
   }
 ]
}
module.exports = databases;