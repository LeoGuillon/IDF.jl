@testset "data.jl" begin
    @testset "load_data" begin
        # non existant file
        @test_throws ErrorException IDF.load_data("nonexistant")

        #station list loading
        df = IDF.load_data(station_list)
    end

    @testset "load_station" begin
        # non existant file
        @test_throws ErrorException IDF.load_station("nonexistant")

        #station loading
        df = IDF.load_station("8100512")
    end
end