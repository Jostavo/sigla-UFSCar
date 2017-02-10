class Digital{
  private:
    string json_string;
    json data;

    size_t write_json(char * ptr, size_t size, size_t nmemb);
    static size_t write_callback(char * ptr, size_t size, size_t nmemb, void * userdata);

  public:
    void write_data(string name);
    int get_data();
}
