function add_func(f, funcs, seen_set, sort_key)
    if ~(seen_set.isin(f))
        funcs.append(f);
        seen_set.append(f);
        if exist('sort_key', 'var')
            funcs.sort(sort_key);
        end
    end
end
