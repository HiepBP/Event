using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace YTicket.API2.Respositories
{
    public abstract class GenericRespository<C, T> :
        IGenericRespository<T> where T : class where C : DbContext, new()
    {
        private C _entities = new C();
        public C Context
        {
            get { return _entities; }
            set { _entities = value; }
        }

        public T Add(T entity)
        {
            _entities.Set<T>().Add(entity);
            _entities.SaveChanges();
            return entity;
        }

        public async Task<T> AddAsync(T entity)
        {
            _entities.Set<T>().Add(entity);
            await _entities.SaveChangesAsync();
            return entity;
        }

        public int Count()
        {
            return _entities.Set<T>().Count();
        }

        public async Task<int> CountAsync()
        {
            return await _entities.Set<T>().CountAsync();
        }

        public void Delete(T entity)
        {
            _entities.Set<T>().Remove(entity);
            _entities.SaveChanges();
        }

        public async Task<int> DeleteAsync(T entity)
        {
            _entities.Set<T>().Remove(entity);
            return await _entities.SaveChangesAsync();
        }

        public T Find(Expression<Func<T, bool>> match)
        {
            return _entities.Set<T>().SingleOrDefault(match);
        }

        public IEnumerable<T> FindAll(Expression<Func<T, bool>> match)
        {
            return _entities.Set<T>().Where(match).ToList();
        }

        public async Task<IEnumerable<T>> FindAllAsync(Expression<Func<T, bool>> match)
        {
            return await _entities.Set<T>().Where(match).ToListAsync();
        }

        public async Task<T> FindAsync(Expression<Func<T, bool>> match)
        {
            return await _entities.Set<T>().SingleOrDefaultAsync(match);
        }

        public T Get(int id)
        {
            return _entities.Set<T>().Find(id);
        }

        public IEnumerable<T> GetAll()
        {
            return _entities.Set<T>().ToList();
        }

        public async Task<IEnumerable<T>> GetAllAsync()
        {
            return await _entities.Set<T>().ToListAsync();
        }

        public async Task<T> GetAsync(int id)
        {
            return await _entities.Set<T>().FindAsync(id);
        }

        public T Update(T entity, int id)
        {
            if (entity == null)
            {
                return null;
            }

            T existing = _entities.Set<T>().Find(id);
            if (existing != null)
            {
                _entities.Entry(existing).CurrentValues.SetValues(entity);
                _entities.SaveChanges();
            }
            return existing;
        }

        public async Task<T> UpdateAsync(T entity, int id)
        {
            if (entity == null)
            {
                return null;
            }

            T existing = await _entities.Set<T>().FindAsync(id);
            if (existing != null)
            {
                _entities.Entry(existing).CurrentValues.SetValues(entity);
                await _entities.SaveChangesAsync();
            }
            return existing;
        }
    }


    public interface IGenericRespository<T> where T : class
    {
        IEnumerable<T> GetAll();
        Task<IEnumerable<T>> GetAllAsync();
        T Get(int id);
        Task<T> GetAsync(int id);
        T Find(Expression<Func<T, bool>> match);
        Task<T> FindAsync(Expression<Func<T, bool>> match);
        IEnumerable<T> FindAll(Expression<Func<T, bool>> match);
        Task<IEnumerable<T>> FindAllAsync(Expression<Func<T, bool>> match);
        T Add(T entity);
        Task<T> AddAsync(T entity);
        T Update(T entity, int id);
        Task<T> UpdateAsync(T entity, int id);
        void Delete(T entity);
        Task<int> DeleteAsync(T entity);
        int Count();
        Task<int> CountAsync();
    }
}