import csv

WORLD_CITIES_PATH = "worldcities.csv"
POPULATION_CUTOFF = 100000
CITIES_CHECKLIST = ["Accra", "Bengaluru", "New Orleans", "Jena", "Temuco", "Hangzhou"]


def main():
    LIST_OF_STRINGS = []
    CITIES_SO_FAR = {}
    num_cities = 0
    is_first_row = True
    with open(WORLD_CITIES_PATH) as file:
        data = csv.reader(file)
        for line in data:
            if is_first_row:
                is_first_row = False; continue
            population = float(line[9]) if len(line[9]) > 0 else 0
            if population < POPULATION_CUTOFF:
                continue
            city_name_ascii_country_nonascii = "\"" + line[1] + ", " + line[4] + "\"" + ":"
            if city_name_ascii_country_nonascii in CITIES_SO_FAR:
                if CITIES_SO_FAR[city_name_ascii_country_nonascii] > population:
                    index_to_remove = 0
                    for ind in range(len(LIST_OF_STRINGS)):
                        if LIST_OF_STRINGS[ind].startswith(city_name_ascii_country_nonascii):
                            index_to_remove = ind
                    LIST_OF_STRINGS.pop(index_to_remove)
                    LIST_OF_STRINGS.pop(index_to_remove) # remove city name and lat long
                else:
                    continue
            LIST_OF_STRINGS.append(city_name_ascii_country_nonascii)
            CITIES_SO_FAR[city_name_ascii_country_nonascii] = population
            city_lat_long = "[" + line[2] + "," + line[3] + "]," + "\n"
            LIST_OF_STRINGS.append(city_lat_long)
            num_cities += 1
        output = ''.join(LIST_OF_STRINGS)
        print(output)
        print("TOTAL CITIES: ", num_cities)
        if all(city in output for city in CITIES_CHECKLIST):
            print("CHECKLIST PASS")
        else:
            print("CHECKLIST FAIL")

if __name__ == "__main__":
    main()