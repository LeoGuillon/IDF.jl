@testset "data.jl" begin
    @testset "load_data" begin
        # non existant file
        @test_throws ErrorException IDF.load_data("nonexistant")

        #station list loading
        @testset "station_list" begin
            df = IDF.load_data("station_list")
            @test df[1, :Name] == "CAMROSE"
        end
        
    end

    @testset "load_station" begin
        # non existant file
        @test_throws ErrorException IDF.load_station("nonexistant")

        # first station loading
        df = load_station("110FAG9")
        
        @test df[1, 2] == 6.6
    end
end