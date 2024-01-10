//
//  MovieServiceSpec.swift
//  MoviesTests
//
//  Created by Adam Cseke on 11/01/2024.
//

@testable import Movies
import Foundation
import Nimble
import Quick
import Combine
import Moya
import Swinject
import InjectPropertyWrapper

private var expectedGetMoviesResponse = EndpointSampleResponse.networkResponse(502, Data())

class MovieServiceSpec: QuickSpec {
    override func spec() {
        describe("Movies Service") {
            var sut: MovieService!
            var assembler: MainAssembler!
            var cancellable: Set<AnyCancellable>!

            beforeEach {
                assembler = MainAssembler.create(withAssemblies: [TestAssembly()])
                InjectSettings.resolver = assembler.container
                sut = assembler.resolver.resolve(MovieServiceProtocol.self) as? MovieService
                cancellable = Set<AnyCancellable>()
            }

            afterEach {
                sut = nil
                assembler.dispose()
                cancellable = nil
            }

            it("has a Moya provider") {
                expect(sut.moya).toNot(beNil())
            }

            context("getUserDetail") {
                context("on success") {
                    var emittedResponse: Movies?
                    let responseFromServer: Movies = try! JSONDecoder().decode(Movies.self, from: getMoviesSuccessResponseData)
                    beforeEach {
                        expectedGetMoviesResponse = .networkResponse(200, getMoviesSuccessResponseData)
                        sut.getMovies()
                            .sink { completion in
                                switch completion {
                                case .finished:
                                    break
                                case .failure(let error):
                                   debugPrint(error.localizedDescription)
                                }
                            } receiveValue: { heroes in
                                emittedResponse = heroes
                            }.store(in: &cancellable)
                    }

                    it("emits the correct response") {
                        expect(emittedResponse?.results).to(equal(responseFromServer.results))
                    }
                }
            }
        }
    }
}

extension MovieServiceSpec {

    class TestAssembly: TestServiceAssembly {
        override func assemble(container: Container) {
            super.assemble(container: container)
            container.register(MovieServiceProtocol.self) { _ in
                MovieService()
            }.inObjectScope(.transient)
        }

        override func createStubEndpoint(withMultiTarget multiTarget: MultiTarget) -> Endpoint {
            guard let target = multiTarget.target as? APIHandler else {
                preconditionFailure("Target is not \(String(describing: APIHandler.self))")
            }
            var sampleResponseClosure: Endpoint.SampleResponseClosure
            switch target {
            case .getMovies:
                sampleResponseClosure = { expectedGetMoviesResponse }
            case .getGenres:
                sampleResponseClosure = { expectedGetMoviesResponse }
            }
            return Endpoint(
                url: url(target),
                sampleResponseClosure: sampleResponseClosure,
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers)
        }
    }
}

private let getMoviesSuccessResponseData = """
{
   "page":1,
   "results":[
      {
         "adult":false,
         "backdrop_path":"/f1AQhx6ZfGhPZFTVKgxG91PhEYc.jpg",
         "id":753342,
         "title":"Napoleon",
         "original_language":"en",
         "original_title":"Napoleon",
         "overview":"An epic that details the checkered rise and fall of French Emperor Napoleon Bonaparte and his relentless journey to power through the prism of his addictive, volatile relationship with his wife, Josephine.",
         "poster_path":"/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg",
         "media_type":"movie",
         "genre_ids":[
            36,
            10752,
            18
         ],
         "popularity":780.447,
         "release_date":"2023-11-22",
         "video":false,
         "vote_average":6.426,
         "vote_count":957
      },
      {
         "adult":false,
         "backdrop_path":"/rVJfabCz1ViynQCEz54MRqdZig1.jpg",
         "id":1155089,
         "title":"Justice League: Crisis on Infinite Earths Part One",
         "original_language":"en",
         "original_title":"Justice League: Crisis on Infinite Earths Part One",
         "overview":"Death is coming. Worse than death: oblivion. Not just for our Earth, but for everyone, everywhere, in every universe! Against this ultimate destruction, the mysterious Monitor has gathered the greatest team of Super Heroes ever assembled. But what can the combined might of Superman, Wonder Woman, Batman, The Flash, Green Lantern and hundreds of Super Heroes from multiple Earths even do to save all of reality from an unstoppable antimatter armageddon?!",
         "poster_path":"/zR6C66EDklgTPLHRSmmMt5878MR.jpg",
         "media_type":"movie",
         "genre_ids":[
            16,
            878,
            28
         ],
         "popularity":74.416,
         "release_date":"2024-01-09",
         "video":false,
         "vote_average":7.689,
         "vote_count":45
      },
      {
         "adult":false,
         "backdrop_path":"/vdpE5pjJVql5aD6pnzRqlFmgxXf.jpg",
         "id":906126,
         "title":"Society of the Snow",
         "original_language":"es",
         "original_title":"La sociedad de la nieve",
         "overview":"On October 13, 1972, Uruguayan Air Force Flight 571, chartered to take a rugby team to Chile, crashes into a glacier in the heart of the Andes.",
         "poster_path":"/k7rEpZfNPB35FFHB00ZhXHKTL7X.jpg",
         "media_type":"movie",
         "genre_ids":[
            18,
            36
         ],
         "popularity":1435.957,
         "release_date":"2023-12-13",
         "video":false,
         "vote_average":8.134,
         "vote_count":513
      },
      {
         "adult":false,
         "backdrop_path":"/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
         "id":872585,
         "title":"Oppenheimer",
         "original_language":"en",
         "original_title":"Oppenheimer",
         "overview":"The story of J. Robert Oppenheimer's role in the development of the atomic bomb during World War II.",
         "poster_path":"/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
         "media_type":"movie",
         "genre_ids":[
            18,
            36
         ],
         "popularity":785.64,
         "release_date":"2023-07-19",
         "video":false,
         "vote_average":8.116,
         "vote_count":6019
      },
      {
         "adult":false,
         "backdrop_path":"/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
         "id":866398,
         "title":"The Beekeeper",
         "original_language":"en",
         "original_title":"The Beekeeper",
         "overview":"One man’s campaign for vengeance takes on national stakes after he is revealed to be a former operative of a powerful and clandestine organization known as Beekeepers.",
         "poster_path":"/A7EByudX0eOzlkQ2FIbogzyazm2.jpg",
         "media_type":"movie",
         "genre_ids":[
            28,
            53
         ],
         "popularity":420.001,
         "release_date":"2024-01-11",
         "video":false,
         "vote_average":7.8,
         "vote_count":9
      },
      {
         "adult":false,
         "backdrop_path":"/nHf61UzkfFno5X1ofIhugCPus2R.jpg",
         "id":346698,
         "title":"Barbie",
         "original_language":"en",
         "original_title":"Barbie",
         "overview":"Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.",
         "poster_path":"/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
         "media_type":"movie",
         "genre_ids":[
            35,
            12,
            14
         ],
         "popularity":404.962,
         "release_date":"2023-07-19",
         "video":false,
         "vote_average":7.146,
         "vote_count":6839
      },
      {
         "adult":false,
         "backdrop_path":"/uKP0B8HUJ08fas7NF77Xwu0bolJ.jpg",
         "id":1214314,
         "title":"One More Shot",
         "original_language":"en",
         "original_title":"One More Shot",
         "overview":"Following the attack on the black site in Poland, Navy SEAL Jake Harris is ordered to escort terrorist suspect Amin Mansur to Washington D.C. for interrogation. Before the prisoner transfer process is complete, though, the airport is attacked by a group of heavily armed, well-trained mercenaries.",
         "poster_path":"/gdF3Q1Mcr2XvxLPStQSoQIO2cIj.jpg",
         "media_type":"movie",
         "genre_ids":[
            28,
            53
         ],
         "popularity":27.518,
         "release_date":"2024-01-12",
         "video":false,
         "vote_average":7.286,
         "vote_count":7
      },
      {
         "adult":false,
         "backdrop_path":"/47SVqaO02doJ06tOmrjiWDkwU3T.jpg",
         "id":927107,
         "title":"The Bricklayer",
         "original_language":"en",
         "original_title":"The Bricklayer",
         "overview":"Someone is blackmailing the CIA by assassinating foreign journalists and making it look like the agency is responsible. As the world begins to unite against the U.S., the CIA must lure its most brilliant – and rebellious – operative out of retirement, forcing him to confront his checkered past while unraveling an international conspiracy.",
         "poster_path":"/36pYugctLa70NmwMEgXTR1G31Kq.jpg",
         "media_type":"movie",
         "genre_ids":[
            28,
            53
         ],
         "popularity":145.657,
         "release_date":"2023-12-14",
         "video":false,
         "vote_average":6.593,
         "vote_count":27
      },
      {
         "adult":false,
         "backdrop_path":"/m3s0jyPGtluJ48kD0fUiPjXrRhr.jpg",
         "id":673593,
         "title":"Mean Girls",
         "original_language":"en",
         "original_title":"Mean Girls",
         "overview":"New student Cady Heron is welcomed into the top of the social food chain by the elite group of popular girls called ‘The Plastics,’ ruled by the conniving queen bee Regina George and her minions Gretchen and Karen. However, when Cady makes the major misstep of falling for Regina’s ex-boyfriend Aaron Samuels, she finds herself prey in Regina’s crosshairs. As Cady sets to take down the group’s apex predator with the help of her outcast friends Janis and Damian, she must learn how to stay true to herself while navigating the most cutthroat jungle of all: high school.",
         "poster_path":"/fbbj3viSUDEGT1fFFMNpHP1iUjw.jpg",
         "media_type":"movie",
         "genre_ids":[
            35
         ],
         "popularity":171.763,
         "release_date":"2024-01-10",
         "video":false,
         "vote_average":6.063,
         "vote_count":8
      },
      {
         "adult":false,
         "backdrop_path":"/jXJxMcVoEuXzym3vFnjqDW4ifo6.jpg",
         "id":572802,
         "title":"Aquaman and the Lost Kingdom",
         "original_language":"en",
         "original_title":"Aquaman and the Lost Kingdom",
         "overview":"Black Manta, still driven by the need to avenge his father's death and wielding the power of the mythic Black Trident, will stop at nothing to take Aquaman down once and for all. To defeat him, Aquaman must turn to his imprisoned brother Orm, the former King of Atlantis, to forge an unlikely alliance in order to save the world from irreversible destruction.",
         "poster_path":"/8xV47NDrjdZDpkVcCFqkdHa3T0C.jpg",
         "media_type":"movie",
         "genre_ids":[
            28,
            12,
            14
         ],
         "popularity":1112.367,
         "release_date":"2023-12-20",
         "video":false,
         "vote_average":6.461,
         "vote_count":444
      },
      {
         "adult":false,
         "backdrop_path":"/1jITxVJhkiFJuQuj8NcPLmDNtJg.jpg",
         "id":930564,
         "title":"Saltburn",
         "original_language":"en",
         "original_title":"Saltburn",
         "overview":"Struggling to find his place at Oxford University, student Oliver Quick finds himself drawn into the world of the charming and aristocratic Felix Catton, who invites him to Saltburn, his eccentric family's sprawling estate, for a summer never to be forgotten.",
         "poster_path":"/qjhahNLSZ705B5JP92YMEYPocPz.jpg",
         "media_type":"movie",
         "genre_ids":[
            18,
            35,
            53
         ],
         "popularity":471.253,
         "release_date":"2023-11-16",
         "video":false,
         "vote_average":7.153,
         "vote_count":971
      },
      {
         "adult":false,
         "backdrop_path":"/5a4JdoFwll5DRtKMe7JLuGQ9yJm.jpg",
         "id":695721,
         "title":"The Hunger Games: The Ballad of Songbirds Snakes",
         "original_language":"en",
         "original_title":"The Hunger Games: The Ballad of Songbirds Snakes",
         "overview":"64 years before he becomes the tyrannical president of Panem, Coriolanus Snow sees a chance for a change in fortunes when he mentors Lucy Gray Baird, the female tribute from District 12.",
         "poster_path":"/mBaXZ95R2OxueZhvQbcEWy2DqyO.jpg",
         "media_type":"movie",
         "genre_ids":[
            18,
            878,
            28
         ],
         "popularity":847.005,
         "release_date":"2023-11-15",
         "video":false,
         "vote_average":7.234,
         "vote_count":1415
      },
      {
         "adult":false,
         "backdrop_path":"/gsVC7HMf4VR2XFOyqjTSklY2Tms.jpg",
         "id":792307,
         "title":"Poor Things",
         "original_language":"en",
         "original_title":"Poor Things",
         "overview":"Brought back to life by an unorthodox scientist, a young woman runs off with a debauched lawyer on a whirlwind adventure across the continents. Free from the prejudices of her times, she grows steadfast in her purpose to stand for equality and liberation.",
         "poster_path":"/jV3c2fsBNCJgcesxdNM9O0lwwdT.jpg",
         "media_type":"movie",
         "genre_ids":[
            878,
            10749,
            35
         ],
         "popularity":194.281,
         "release_date":"2023-11-21",
         "video":false,
         "vote_average":8.0,
         "vote_count":79
      },
      {
         "adult":false,
         "backdrop_path":"/kqSxCsGIT4rqrZTTMpYP8RIzojv.jpg",
         "id":720557,
         "title":"Tiger 3",
         "original_language":"hi",
         "original_title":"Tiger 3",
         "overview":"Following the events of Tiger Zinda Hai, War, and Pathaan, Avinash Singh Rathore returns as Tiger but this time the battle is within. He has to choose between his country or family as an old enemy is after his life, who claims that his family was killed by Tiger. He holds Tiger captive in Pakistan as the Indian agent's loyalty towards his country faces its biggest test.",
         "poster_path":"/7wgED7Yx9VLcNWSO91VgwicHmMD.jpg",
         "media_type":"movie",
         "genre_ids":[
            28,
            12,
            53
         ],
         "popularity":79.687,
         "release_date":"2023-11-12",
         "video":false,
         "vote_average":6.8,
         "vote_count":12
      },
      {
         "adult":false,
         "backdrop_path":"/t5zCBSB5xMDKcDqe91qahCOUYVV.jpg",
         "id":507089,
         "title":"Five Nights at Freddy's",
         "original_language":"en",
         "original_title":"Five Nights at Freddy's",
         "overview":"Recently fired and desperate for work, a troubled young man named Mike agrees to take a position as a night security guard at an abandoned theme restaurant: Freddy Fazbear's Pizzeria. But he soon discovers that nothing at Freddy's is what it seems.",
         "poster_path":"/7BpNtNfxuocYEVREzVMO75hso1l.jpg",
         "media_type":"movie",
         "genre_ids":[
            27,
            9648
         ],
         "popularity":860.199,
         "release_date":"2023-10-25",
         "video":false,
         "vote_average":7.755,
         "vote_count":3116
      },
      {
         "adult":false,
         "backdrop_path":"/ckAwjXyW7LQEbvjdbzJGEJNSfWl.jpg",
         "id":374252,
         "title":"Shaun the Sheep: The Farmer's Llamas",
         "original_language":"en",
         "original_title":"Shaun the Sheep: The Farmer's Llamas",
         "overview":"Shaun bluffs his dimwitted farmer master into bidding for three llamas at a county fair. Once they arrive, however, they cause such chaotic destructive mayhem that Shaun has to carefully remove them – high-speed chases, careful rooftop scrambles and dangerous falls ensue.",
         "poster_path":"/a3wjyadC2l3ehoqHjKlk5w89ErM.jpg",
         "media_type":"movie",
         "genre_ids":[
            10770,
            10751,
            16,
            35
         ],
         "popularity":19.648,
         "release_date":"2015-11-13",
         "video":false,
         "vote_average":6.759,
         "vote_count":54
      },
      {
         "adult":false,
         "backdrop_path":"/k1KrbaCMACQiq7EA0Yhw3bdzMv7.jpg",
         "id":901362,
         "title":"Trolls Band Together",
         "original_language":"en",
         "original_title":"Trolls Band Together",
         "overview":"When Branch's brother, Floyd, is kidnapped for his musical talents by a pair of nefarious pop-star villains, Branch and Poppy embark on a harrowing and emotional journey to reunite the other brothers and rescue Floyd from a fate even worse than pop-culture obscurity.",
         "poster_path":"/bkpPTZUdq31UGDovmszsg2CchiI.jpg",
         "media_type":"movie",
         "genre_ids":[
            16,
            10751,
            10402,
            14,
            35
         ],
         "popularity":524.936,
         "release_date":"2023-10-12",
         "video":false,
         "vote_average":7.191,
         "vote_count":497
      },
      {
         "adult":false,
         "backdrop_path":"/sRLC052ieEzkQs9dEtPMfFxYkej.jpg",
         "id":848326,
         "title":"Rebel Moon - Part One: A Child of Fire",
         "original_language":"en",
         "original_title":"Rebel Moon - Part One: A Child of Fire",
         "overview":"When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.",
         "poster_path":"/ui4DrH1cKk2vkHshcUcGt2lKxCm.jpg",
         "media_type":"movie",
         "genre_ids":[
            878,
            18,
            28
         ],
         "popularity":806.716,
         "release_date":"2023-12-15",
         "video":false,
         "vote_average":6.447,
         "vote_count":1162
      },
      {
         "adult":false,
         "backdrop_path":"/cUhNEu8Z4KEIK0fywzlpVz08LTT.jpg",
         "id":760245,
         "title":"Foe",
         "original_language":"en",
         "original_title":"Foe",
         "overview":"Henrietta and Junior farm a secluded piece of land that has been in Junior's family for generations, but their quiet life is thrown into turmoil when an uninvited stranger shows up at their door with a startling proposal. Will they risk their relationship personal identity for a chance to survive in a new world?",
         "poster_path":"/tDl5sgrgiKSuryuSyjOR1ngBuVO.jpg",
         "media_type":"movie",
         "genre_ids":[
            878,
            9648,
            53,
            18
         ],
         "popularity":150.322,
         "release_date":"2023-10-06",
         "video":false,
         "vote_average":5.566,
         "vote_count":83
      },
      {
         "adult":false,
         "backdrop_path":"/sQLMaESdeELB7Dl8HdxfGlZYRzu.jpg",
         "id":840430,
         "title":"The Holdovers",
         "original_language":"en",
         "original_title":"The Holdovers",
         "overview":"A curmudgeonly instructor at a New England prep school is forced to remain on campus during Christmas break to babysit the handful of students with nowhere to go. Eventually, he forms an unlikely bond with one of them — a damaged, brainy troublemaker — and with the school’s head cook, who has just lost a son in Vietnam.",
         "poster_path":"/VHSzNBTwxV8vh7wylo7O9CLdac.jpg",
         "media_type":"movie",
         "genre_ids":[
            35,
            18
         ],
         "popularity":128.913,
         "release_date":"2023-10-27",
         "video":false,
         "vote_average":7.66,
         "vote_count":324
      }
   ],
   "total_pages":1000,
   "total_results":20000
}
""".data(using: .utf8)!


