#include <erl_nif.h>
#include <string>
#include <vector>
#include <gfx/timsort.hpp>
#include <iostream>
#include <iterator>

using namespace std;

// Elixir (Erlang/Beam) NIF call to the C++ implementation of timsort

// TODO Handle Vectors with strings and then arbitrary types in the vector

// Convert a C-style array into a C++ vector<double>.
bool enif_fill_vector(ErlNifEnv* env, ERL_NIF_TERM listTerm,
    vector<double> &result, unsigned int length)
{
    double actualHead;
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
        if (!enif_get_double(env, head, &actualHead))
        {
            return false;
        }
        result.push_back(actualHead);
    }

    return true;
}
// Convert a C-style array into a C++ vector<int>.
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

// Perform the sort task on a list of doubles
// Convert the Elixir types (Lists) into a C-style array.
static ERL_NIF_TERM
sort_double(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    vector<double> a;
    unsigned int length = 0;

    if (!enif_get_list_length(env, argv[0], &length))
    {
        return false;
    }

    if (!enif_fill_vector(env, argv[0], a, length))
    {
        return enif_make_badarg(env);
    }

    // Call C++ TimSort implementation (works on vectors)
    gfx::timsort(a.begin(), a.end(), less<double>());

    // Allocate an empty list. Allow enif_make_list_cell to 'refill'
    // the list with the sorted values. (Backwards, since we are prepending the
    // the value to the HEAD of the list.)
    ERL_NIF_TERM result = enif_make_list(env, 0);
    for (unsigned int i = length; i > 0; i--) {
        result = enif_make_list_cell(env, enif_make_double(env, a[i-1]), result);
    }

    return result;
}


// Perform the sort task.
// Convert the Elixir types (Lists) into a C-style array.
static ERL_NIF_TERM
sort_int(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
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

    // Call C++ TimSort implementation (works on vectors)
    gfx::timsort(a.begin(), a.end(), less<int>());

    // Allocate an empty list. Allow enif_make_list_cell to 'refill'
    // the list with the sorted values. (Backwards, since we are prepending the
    // the value to the HEAD of the list.)
    ERL_NIF_TERM result = enif_make_list(env, 0);
    for (unsigned int i = length; i > 0; i--) {
        result = enif_make_list_cell(env, enif_make_int(env, a[i-1]), result);
    }

    return result;
}

// Map the Elixir fn to the C nif_func.
static ErlNifFunc nif_funcs[] = {
    {"sort_int", 1, sort_int},
    {"sort_float", 1, sort_double}
    // {"sort_d", 1, sort_int, ERL_NIF_DIRTY_JOB_CPU_BOUND}
    // {"sort_d", 1, sort_double, ERL_NIF_DIRTY_JOB_CPU_BOUND}
};

// ERL_NIF_INIT(Elixir.TimsortCppEx, nif_funcs, load, reload, upgrade, unload);
ERL_NIF_INIT(Elixir.TimsortCppEx, nif_funcs, nullptr, nullptr, nullptr, nullptr);
// #include <src/cpp-TimSort/include/gfx/timsort.hpp>
// #include </Users/christiankoch/code/cpp-TimSort/include/gfx/timsort.hpp>
// #include </usr/local/include/erl_nif.h>
