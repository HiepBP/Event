using System;
using System.Web.Http.ModelBinding;

namespace YTicket.API2.Models
{
    public class ModelStateWrapper : IValidationDictionary
    {
        private ModelStateDictionary _modelState;

        public ModelStateWrapper(ModelStateDictionary modelState)
        {
            _modelState = modelState;
        }

        #region IValidationDictionary Members

        public bool IsValid
        {
            get
            {
                return _modelState.IsValid;
            }
        }

        public void AddErrors(string key, string errorMessage)
        {
            _modelState.AddModelError(key, errorMessage);
        }

        #endregion
    }
}