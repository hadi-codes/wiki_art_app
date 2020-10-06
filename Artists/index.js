const jsonfile = require('jsonfile')
const file = './artists.json'

const axios = require('axios');
let baseUrl = "https://www.wikiart.org/en/api/2"

const instance = axios.create({
    baseURL: baseUrl
});

async function run() {
    let artistDictionary = {};
    artistDictionary.hasMore = 'unknown'
    let artist = []
    do {
        console.log(artist.length);
        artistDictionary = await getArtistDictionart(artistDictionary).catch((err) => {
            console.log(`fin ${artist.length}`);
            jsonfile.writeFile(file, { artist }, function(err) {
                if (err) console.error(err)
            })
        })
        artist.push.apply(artist, artistDictionary.data)
    } while (artistDictionary.hasMore = true);




}

async function getArtistDictionart(artistDictionary) {
    return new Promise(async(resovle, rejcet) => {
        try {
            let res;
            res = await instance(artistDictionary.hasMore === 'unknown' ? '/UpdatedArtists' : `/UpdatedArtists?paginationToken=${artistDictionary.paginationToken}`)
            resovle(res.data);
        } catch (error) {
            rejcet(error)
        }
    })
}
run()