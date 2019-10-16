#include <erl_nif.h>
#include <string>
#include <vector>
#include <gfx/timsort.hpp>
#include <iostream>
#include <iterator>

using namespace std;

// #include <src/cpp-TimSort/include/gfx/timsort.hpp>
// #include </Users/christiankoch/code/cpp-TimSort/include/gfx/timsort.hpp>
// #include </usr/local/include/erl_nif.h>
// Elixir (Erlang/Beam) NIF call to the C++ implementation of timsort


bool enif_fill_vector(ErlNifEnv* env, ERL_NIF_TERM listTerm,
    vector<int> &result, unsigned int length)
{

    int actualHead;
    ERL_NIF_TERM head;
    ERL_NIF_TERM tail;
    ERL_NIF_TERM currentList = listTerm;
    for (unsigned int i = 0; i < length; ++i)
    {
        if (!enif_get_list_cell(env, currentList, &head, &tail))
        {
            return false;
        }
        currentList = tail;
        if (!enif_get_int(env, head, &actualHead))
        {
            return false;
        }
        result.push_back(actualHead);
    }

    return true;
}

static ERL_NIF_TERM
sort_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    vector<int> a;
    unsigned int length = 0;

    if (!enif_get_list_length(env, argv[0], &length))
    {
        return false;
    }

    if (!enif_fill_vector(env, argv[0], a, length))
    {
        return enif_make_badarg(env);
    }

    cout << 'L' << 'E' << 'N' << 'G' << 'T' << 'H' << ' ' << length << '\n';
    for (unsigned int i = 0; i < length; ++i) {
        cout << a[i] << ' ';
    }
    cout << '\n';
    // copy(a.begin(), a.end(), ostream_iterator<int>(cout, " "));

    gfx::timsort(a.begin(), a.end(), less<int>());

    // for (unsigned int i = 0; i < length; ++i) {
    //     cout << a[i] << ' ';
    // }
    // cout << '\n';
    // copy(a.begin(), a.end(), ostream_iterator<int>(cout, " "));

    // ERL_NIF_TERM result = a;
    // ERL_NIF_TERM arr[length];
    // copy(a.begin(), a.end(), arr);

    int *arr = new int[length];
    for (int i = 0; i < length; i++) {
        arr[i] = a[i];
        std::cout << arr[i] << ' ';
    }
    cout << '\n';

    // for (int i: arr) {
        // std::cout << i << ' ';
    // }
    // ERL_NIF_TERM result = enif_make_list_from_array(env, arr, length);

    // ERL_NIF_TERM result;
    ERL_NIF_TERM result = enif_make_list(env, 0);

    for (unsigned int i = length; i > 0; i--) {
        result = enif_make_list_cell(env, enif_make_int(env, a[i-1]), result);
        cout << a[i] << ' ';
    }

    return result;
}

static ErlNifFunc nif_funcs[] = {{"sort", 1, sort_nif}};


// Basic fns used by ERL_NIF_INIT
static int
load(ErlNifEnv* env, void** priv, ERL_NIF_TERM load_info)
{
    return 0;
}

static int
reload(ErlNifEnv* env, void** priv, ERL_NIF_TERM load_info)
{
    return 0;
}

static int
upgrade(ErlNifEnv* env, void** priv, void** old_priv,
          ERL_NIF_TERM load_info)
{
    return 0;
}

static void
unload(ErlNifEnv* env, void* priv)
{
    return;
}

ERL_NIF_INIT(Elixir.TimsortCppEx, nif_funcs, load, reload, upgrade, unload);
// ERL_NIF_INIT(Elixir.TimsortCppEx, nif_funcs, nullptr, nullptr, nullptr, nullptr);
