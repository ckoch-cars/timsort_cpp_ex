#include <erl_nif.h>
#include <string>
#include <vector>
#include <gfx/timsort.hpp>
#include <iostream>
#include <iterator>

// #include <src/cpp-TimSort/include/gfx/timsort.hpp>
// #include </Users/christiankoch/code/cpp-TimSort/include/gfx/timsort.hpp>
// #include </usr/local/include/erl_nif.h>
// Elixir (Erlang/Beam) NIF call to the C++ implementation of timsort


bool enif_fill_vector(ErlNifEnv* env, ERL_NIF_TERM listTerm,
    std::vector<int> &result, unsigned int length)
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
    std::vector<int> a;
    unsigned int length = 0;

    if (!enif_get_list_length(env, argv[0], &length))
    {
        return false;
    }

    if (!enif_fill_vector(env, argv[0], a, length))
    {
        return enif_make_badarg(env);
    }

    gfx::timsort(a.begin(), a.end(), std::less<int>());

    ERL_NIF_TERM result = enif_make_list(env, length);

    std::copy(a.begin(),
        a.end(),
        std::ostream_iterator<int>(std::cout, " "));

    for (unsigned int i = 0; i < length; ++i) {
        std::cout << a[i] << ' ';
        result = enif_make_list_cell(env, enif_make_int(env, a[i]), result);
    }

    return result;
}

static ErlNifFunc nif_funcs[] = {{"sort", 1, sort_nif}};

ERL_NIF_INIT(Elixir.TimsortCppEx, nif_funcs, nullptr,
    nullptr, nullptr, nullptr);
